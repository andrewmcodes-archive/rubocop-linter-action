require './spec/spec_helper'

describe ReportAdapter do
  let(:rubocop_report) {
    JSON(File.read('./spec/fixtures/report.json'))
  }

  let(:adapter) { ReportAdapter }

  it '.conslusion' do
    result = adapter.conslusion(rubocop_report)
    expect(result).to eq('failure')
  end

  it '.summary' do
    result = adapter.summary(rubocop_report)
    expect(result).to eq('201 offense(s) found')
  end

  it '.annotations' do
    result = adapter.annotations(rubocop_report)
    expect(result.first).to eq({
      'path' => 'Gemfile',
      'start_line' => 1,
      'end_line' => 1,
      'annotation_level' => 'failure',
      'message' => 'Missing magic comment `# frozen_string_literal: true`.'
    })
  end
end
