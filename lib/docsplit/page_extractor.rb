module Docsplit

  # Delegates to **pdftk** in order to create bursted single pages from
  # a PDF document.
  class PageExtractor

    # Burst a list of pdfs into single pages, as `pdfname_pagenumber.pdf`.
    def extract(pdf, opts)
      extract_options opts
      output_path = ESCAPE[@output]
      cmd = "pdftk #{ESCAPE[pdf.first]} cat #{@pages} output #{output_path} 2>&1"
      result = `#{cmd}`.chomp
      FileUtils.rm('doc_data.txt') if File.exists?('doc_data.txt')
      raise ExtractionFailed, result if $? != 0
      result
    end


    private

    def extract_options(options)
      @output = options[:output] || '.'
      @pages = options[:pages].join(' ') || '1'
    end

  end

end
