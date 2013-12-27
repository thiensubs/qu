class SimpleJob < Qu::Job
end

class CustomQueue < Qu::Job
  queue :custom
end

shared_examples_for 'a backend' do |options|
  options ||= {}

  services = Array(options[:services]).inject({}) { |hash, service|
    hash[service] = service_running?(service)
    hash
  }

  down_services = services.select { |k, v| !v }.keys

  if down_services.empty?
    let(:worker) { Qu::Worker.new('default') }
    let(:payload) { Qu::Payload.new(:klass => SimpleJob) }

    before(:all) do
      Qu.backend = described_class.new
    end

    before do
      subject.clear(payload.queue)
    end

    describe 'push' do
      it 'should return a payload' do
        subject.push(payload.queue, payload).should be_instance_of(Qu::Payload)
      end

      it 'should set the payload id' do
        subject.push(payload.queue, payload)
        payload.id.should_not be_nil
      end

      it 'should add a job to the queue' do
        subject.push(payload.queue, payload)
        payload.queue.should == 'default'
        subject.size(payload.queue).should == 1
      end

      it 'should assign a different job id for the same job pushed multiple times' do
        first = subject.push(payload.queue, payload).id
        second = subject.push(payload.queue, payload).id
        first.should_not eq(second)
      end
    end

    describe 'pop' do
      it 'should return next job' do
        subject.push(payload.queue, payload)
        subject.pop(payload.queue).id.should == payload.id
      end

      it 'should not return an already popped job' do
        subject.push(payload.queue, payload)
        subject.push(payload.queue, payload.dup)
        subject.pop(payload.queue).id.should_not == subject.pop(payload.queue).id
      end

      it 'should not return job from different queue' do
        subject.push(payload.queue, payload)
        subject.pop('video').should be_nil
      end

      it 'should properly persist args' do
        payload.args = ['a', 'b']
        subject.push(payload.queue, payload)
        subject.pop(payload.queue).args.should == ['a', 'b']
      end

      it 'should properly persist a hash argument' do
        payload.args = [{:a => 1, :b => 2}]
        subject.push(payload.queue, payload)
        subject.pop(payload.queue).args.should == [{'a' => 1, 'b' => 2}]
      end
    end

    describe 'complete' do
      it 'should be defined' do
        subject.respond_to?(:complete).should be_true
      end
    end

    describe 'abort' do
      before do
        subject.push(payload.queue, payload)
      end

      it 'should add the job back on the queue' do
        popped_payload = subject.pop(payload.queue)
        popped_payload.id.should == payload.id
        subject.size(payload.queue).should == 0
        subject.abort(popped_payload)
        subject.size(payload.queue).should == 1
      end
    end

    describe 'size' do
      it 'should use the default queue by default' do
        subject.size.should == 0
        subject.push(payload.queue, payload)
        subject.size.should == 1
      end
    end

    describe 'clear' do
      it 'should clear jobs for given queue' do
        subject.push(payload.queue, payload)
        subject.size(payload.queue).should == 1
        subject.clear(payload.queue)
        subject.size(payload.queue).should == 0
      end

      it 'should not clear jobs for a different queue' do
        subject.push(payload.queue, payload)
        subject.clear('other')
        subject.size(payload.queue).should == 1
      end
    end

    describe 'connection=' do
      it 'should allow setting the connection' do
        connection = double('a connection')
        subject.connection = connection
        subject.connection.should == connection
      end

      it 'should provide a default connection' do
        subject.connection.should_not be_nil
      end
    end
  else
    puts "Skipping #{described_class}. Required services are not running (#{down_services.join(', ')})."
  end
end
