module ReturnFile
  def ReturnFile.valid_return_file?(file)
    file.each_line { |line|
      line.chomp!
      return false if line.length != 400
    }
    return true
  end

  def ReturnFile.process_return_file(file)
    titles = []
    file.rewind
    file.readline #pula a primeira linha
    detail = file.readline
    while detail[0,1]!="9" do
      title = Title.update_title detail
      titles << title if title
      detail = file.readline
    end
    titles
  end
end
