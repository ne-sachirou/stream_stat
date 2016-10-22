# frozen_string_literal: true

describe StreamStat do
  context 'Example' do
    require_relative '../example/example'
    Example.all.each do |example|
      it example.description do
        example.eval
      end
    end
  end
end
