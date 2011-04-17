# To change this template, choose Tools | Templates
# and open the template in the editor.

module HasImage
  PATH = "backup/images/"
  private

  def get_image_url(pic,size)
    URI::escape pic.url(size)
  end

  def get_image_dimension(pic,size)
    if pic.file?
      Paperclip::Geometry.from_file(File.new("public#{pic.url(size)}","r")).to_s.split("x")
    else
      nil
    end
  rescue Exception => e
    logger.error e.message
    logger.error e.backtrace
    return pic.instance_values["styles"][size][0].split("x")
  end
  
end
