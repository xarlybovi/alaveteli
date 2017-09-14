# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'zip/zipfilesystem'

describe 'zipping pdf files' do

  it 'correctly records the size of the zipped file' do
    pdf_file = load_file_fixture('tfl.pdf')
    expected_size = pdf_file.size

    tempfile = Tempfile.new('ziptest')
    tempfile.binmode

    Zip::ZipFile.open(tempfile.path + '.zip', Zip::ZipFile::CREATE) do |zipfile|
      zipfile.get_output_stream('tfl.pdf') do |f|
        f.puts pdf_file
      end
    end

    zipped_size = 0
    Zip::ZipFile.open(tempfile.path + '.zip') do |zipfile|
      zipped_size = zipfile.file.size('tfl.pdf')
    end
    tempfile.close

    expect(zipped_size).to eq expected_size
  end

end
