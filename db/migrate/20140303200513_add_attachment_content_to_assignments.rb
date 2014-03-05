class AddAttachmentContentToAssignments < ActiveRecord::Migration
  def self.up
    change_table :assignments do |t|
      t.attachment :content
    end
  end

  def self.down
    drop_attached_file :assignments, :content
  end
end
