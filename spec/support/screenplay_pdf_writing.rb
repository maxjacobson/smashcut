require "pathname"
require "fileutils"

RSpec::Matchers.define :have_pdf do |filename|
  match do |dir|
    dir.join("#{filename}.pdf").exist?
  end
end

module ScreenplayPdfWriting
  def pdf_path(filename = nil)
    filename = filename ? "#{filename}.pdf" : ""
    Pathname.new("./spec/support/generated_pdfs").join(filename)
  end

  def clean_up_pdfs
    Dir.glob(pdf_path("**/*")).each { |pdf| FileUtils.rm(pdf) }
  end
end

RSpec.configure do |config|
  config.include ScreenplayPdfWriting
end
