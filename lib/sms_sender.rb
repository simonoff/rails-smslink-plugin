# SmsSender
module SmsSender
  class Sender
    
    PHONE_FORMAT = /\+38\d{3}\d{7}/
    
    attr_reader :server, :queue, :client_path, :message, :phone
    attr_writer :server, :queue, :client_path, :message, :phone
    
    def initialize
      @server       = "localhost"
      @queue        = false
      @client_path  = '/usr/local/bin/sendsms'
      @message      = nil
      @phone        = 0
    end
    
    def send
      return false unless valid_number?
      return false if self.message.nil?
      command = nil
      command = "#{client_path} -d '#{phone}' -m '#{message}'"
      command << " -Q" if queue
      command << " #{server}"
      system(command)
    end
    
    def valid_number?
      self.phone.to_s.match(PHONE_FORMAT)
    end
    
  end
end
