#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require "thrift"
require_relative "kestrel_types"

module Qu
  module Backend
    class Kestrel < Base
      module Thrift
        class Client
          include ::Thrift::Client

          def put(queue_name, items, expiration_msec)
            send_put(queue_name, items, expiration_msec)
            return recv_put()
          end

          def send_put(queue_name, items, expiration_msec)
            send_message('put', Put_args, :queue_name => queue_name, :items => items, :expiration_msec => expiration_msec)
          end

          def recv_put()
            result = receive_message(Put_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'put failed: unknown result')
          end

          def get(queue_name, max_items, timeout_msec, auto_abort_msec)
            send_get(queue_name, max_items, timeout_msec, auto_abort_msec)
            return recv_get()
          end

          def send_get(queue_name, max_items, timeout_msec, auto_abort_msec)
            send_message('get', Get_args, :queue_name => queue_name, :max_items => max_items, :timeout_msec => timeout_msec, :auto_abort_msec => auto_abort_msec)
          end

          def recv_get()
            result = receive_message(Get_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get failed: unknown result')
          end

          def confirm(queue_name, ids)
            send_confirm(queue_name, ids)
            return recv_confirm()
          end

          def send_confirm(queue_name, ids)
            send_message('confirm', Confirm_args, :queue_name => queue_name, :ids => ids)
          end

          def recv_confirm()
            result = receive_message(Confirm_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'confirm failed: unknown result')
          end

          def abort(queue_name, ids)
            send_abort(queue_name, ids)
            return recv_abort()
          end

          def send_abort(queue_name, ids)
            send_message('abort', Abort_args, :queue_name => queue_name, :ids => ids)
          end

          def recv_abort()
            result = receive_message(Abort_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'abort failed: unknown result')
          end

          def peek(queue_name)
            send_peek(queue_name)
            return recv_peek()
          end

          def send_peek(queue_name)
            send_message('peek', Peek_args, :queue_name => queue_name)
          end

          def recv_peek()
            result = receive_message(Peek_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'peek failed: unknown result')
          end

          def flush_queue(queue_name)
            send_flush_queue(queue_name)
            recv_flush_queue()
          end

          def send_flush_queue(queue_name)
            send_message('flush_queue', Flush_queue_args, :queue_name => queue_name)
          end

          def recv_flush_queue()
            result = receive_message(Flush_queue_result)
            return
          end

          def flush_all_queues()
            send_flush_all_queues()
            recv_flush_all_queues()
          end

          def send_flush_all_queues()
            send_message('flush_all_queues', Flush_all_queues_args)
          end

          def recv_flush_all_queues()
            result = receive_message(Flush_all_queues_result)
            return
          end

          def delete_queue(queue_name)
            send_delete_queue(queue_name)
            recv_delete_queue()
          end

          def send_delete_queue(queue_name)
            send_message('delete_queue', Delete_queue_args, :queue_name => queue_name)
          end

          def recv_delete_queue()
            result = receive_message(Delete_queue_result)
            return
          end

          def current_status()
            send_current_status()
            return recv_current_status()
          end

          def send_current_status()
            send_message('current_status', Current_status_args)
          end

          def recv_current_status()
            result = receive_message(Current_status_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'current_status failed: unknown result')
          end

          def set_status(status)
            send_set_status(status)
            recv_set_status()
          end

          def send_set_status(status)
            send_message('set_status', Set_status_args, :status => status)
          end

          def recv_set_status()
            result = receive_message(Set_status_result)
            return
          end

          def get_version()
            send_get_version()
            return recv_get_version()
          end

          def send_get_version()
            send_message('get_version', Get_version_args)
          end

          def recv_get_version()
            result = receive_message(Get_version_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_version failed: unknown result')
          end

        end

        class Processor
          include ::Thrift::Processor

          def process_put(seqid, iprot, oprot)
            args = read_args(iprot, Put_args)
            result = Put_result.new()
            result.success = @handler.put(args.queue_name, args.items, args.expiration_msec)
            write_result(result, oprot, 'put', seqid)
          end

          def process_get(seqid, iprot, oprot)
            args = read_args(iprot, Get_args)
            result = Get_result.new()
            result.success = @handler.get(args.queue_name, args.max_items, args.timeout_msec, args.auto_abort_msec)
            write_result(result, oprot, 'get', seqid)
          end

          def process_confirm(seqid, iprot, oprot)
            args = read_args(iprot, Confirm_args)
            result = Confirm_result.new()
            result.success = @handler.confirm(args.queue_name, args.ids)
            write_result(result, oprot, 'confirm', seqid)
          end

          def process_abort(seqid, iprot, oprot)
            args = read_args(iprot, Abort_args)
            result = Abort_result.new()
            result.success = @handler.abort(args.queue_name, args.ids)
            write_result(result, oprot, 'abort', seqid)
          end

          def process_peek(seqid, iprot, oprot)
            args = read_args(iprot, Peek_args)
            result = Peek_result.new()
            result.success = @handler.peek(args.queue_name)
            write_result(result, oprot, 'peek', seqid)
          end

          def process_flush_queue(seqid, iprot, oprot)
            args = read_args(iprot, Flush_queue_args)
            result = Flush_queue_result.new()
            @handler.flush_queue(args.queue_name)
            write_result(result, oprot, 'flush_queue', seqid)
          end

          def process_flush_all_queues(seqid, iprot, oprot)
            args = read_args(iprot, Flush_all_queues_args)
            result = Flush_all_queues_result.new()
            @handler.flush_all_queues()
            write_result(result, oprot, 'flush_all_queues', seqid)
          end

          def process_delete_queue(seqid, iprot, oprot)
            args = read_args(iprot, Delete_queue_args)
            result = Delete_queue_result.new()
            @handler.delete_queue(args.queue_name)
            write_result(result, oprot, 'delete_queue', seqid)
          end

          def process_current_status(seqid, iprot, oprot)
            args = read_args(iprot, Current_status_args)
            result = Current_status_result.new()
            result.success = @handler.current_status()
            write_result(result, oprot, 'current_status', seqid)
          end

          def process_set_status(seqid, iprot, oprot)
            args = read_args(iprot, Set_status_args)
            result = Set_status_result.new()
            @handler.set_status(args.status)
            write_result(result, oprot, 'set_status', seqid)
          end

          def process_get_version(seqid, iprot, oprot)
            args = read_args(iprot, Get_version_args)
            result = Get_version_result.new()
            result.success = @handler.get_version()
            write_result(result, oprot, 'get_version', seqid)
          end

        end

        # HELPER FUNCTIONS AND STRUCTURES

        class Put_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1
          ITEMS = 2
          EXPIRATION_MSEC = 3

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'},
            ITEMS => {:type => ::Thrift::Types::LIST, :name => 'items', :element => {:type => ::Thrift::Types::STRING, :binary => true}},
            EXPIRATION_MSEC => {:type => ::Thrift::Types::I32, :name => 'expiration_msec', :default => 0}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Put_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1
          MAX_ITEMS = 2
          TIMEOUT_MSEC = 3
          AUTO_ABORT_MSEC = 4

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'},
            MAX_ITEMS => {:type => ::Thrift::Types::I32, :name => 'max_items'},
            TIMEOUT_MSEC => {:type => ::Thrift::Types::I32, :name => 'timeout_msec', :default => 0},
            AUTO_ABORT_MSEC => {:type => ::Thrift::Types::I32, :name => 'auto_abort_msec', :default => 0}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => Item}}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Confirm_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1
          IDS = 2

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'},
            IDS => {:type => ::Thrift::Types::SET, :name => 'ids', :element => {:type => ::Thrift::Types::I64}}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Confirm_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Abort_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1
          IDS = 2

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'},
            IDS => {:type => ::Thrift::Types::SET, :name => 'ids', :element => {:type => ::Thrift::Types::I64}}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Abort_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Peek_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Peek_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => QueueInfo}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Flush_queue_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Flush_queue_result
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Flush_all_queues_args
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Flush_all_queues_result
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Delete_queue_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUEUE_NAME = 1

          FIELDS = {
            QUEUE_NAME => {:type => ::Thrift::Types::STRING, :name => 'queue_name'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Delete_queue_result
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Current_status_args
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Current_status_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success', :enum_class => Status}
          }

          def struct_fields; FIELDS; end

          def validate
            unless @success.nil? || Status::VALID_VALUES.include?(@success)
              raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field success!')
            end
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Set_status_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          STATUS = 1

          FIELDS = {
            STATUS => {:type => ::Thrift::Types::I32, :name => 'status', :enum_class => Status}
          }

          def struct_fields; FIELDS; end

          def validate
            unless @status.nil? || Status::VALID_VALUES.include?(@status)
              raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field status!')
            end
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Set_status_result
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_version_args
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_version_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end
      end
    end
  end
end
