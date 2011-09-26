#coding: utf-8

require File.expand_path(File.dirname(__FILE__) + "/../../../lib/bands/header_band")

module PrawnReport

  #This header renders:
  #
  #* Company name based on a property at the root of data named +company_name+  left aligned
  #  font size 16.
  #* Data de emissão dated today right aligned font size 12
  #* Report name based on a parameter named +report_name+ setted in the report
  class Header001 < HeaderBand
    
    def internal_draw
      report.text(report.data['company_name'], 300, :style => :bold, :font_size => 16)
      txt_emissao = 'Data de emissão: ' + Date.today.strftime('%d/%m/%Y')
      length = report.pdf.width_of(txt_emissao, :size => 12)
      report.x = report.max_width - length
      report.text(txt_emissao, length, :font_size => 12, 
        :valign => :bottom, :align => :right)
      report.line_break(16)
      report.text(report.params[:report_name], report.max_width, :font_size => 13, 
         :align => :center)
      report.line_break(13)
      draw_filters if report.params[:filters]
      report.horizontal_line
    end
    
    def draw_filters
      report.params[:filters].each do |param|
        title = param[0]
        if param[1].to_s != ''
          title = title + ':'
        end
        report.text(title, 2 + report.pdf.width_of(title, :size => 10), :font_size => 10)
        report.text(param[1], 2 + report.pdf.width_of(param[1], :size => 10), :font_size => 10)
        report.line_break(10)
      end
    end
    
    def height
      filter_count = 0
      report.params[:filters].count if report.params[:filters]
      55 + 10 * filter_count
    end
        
  end
  
end
