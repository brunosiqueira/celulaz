class CleanMessageCopiesTrash < ActiveRecord::Migration
  def self.up
    MessageCopy.find(:all).each do |m|
      if m.message.nil?
        puts "excluindo mensagem:#{m.id}"
        MessageCopy.destroy(m.id)
      end
    end
  end

  def self.down
  end
end
