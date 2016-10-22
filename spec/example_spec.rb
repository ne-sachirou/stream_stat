# frozen_string_literal: true

describe StreamStat do
  context 'Example' do
    require_relative '../example/example'
    Example.all.each do |example|
      it example.description do
        expect { example.eval }.not_to raise_error
      end
    end
  end
end
