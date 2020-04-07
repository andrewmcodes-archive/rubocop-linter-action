# frozen_string_literal: true

require "open3"

class Results
  attr_accessor :output, :status_code

  def initialize(command)
    Open3.popen2(command) do |stdin, stdout, thread|
      stdin.close
      @output = stdout.read
      @status_code = thread.value.exitstatus
    end
  end

  def build
    insert_exit_code
    parsed_results
  end

  private

  def parsed_results
    @parsed_results ||= JSON.parse(output)
  end

  def insert_exit_code
    parsed_results["__exit_code"] = status_code
  end
end
