class Document < ApplicationRecord
  has_one_attached :doc
  belongs_to :documentable
  attr_accessor :doc_contents
  attr_accessor :doc_name

  after_create :parse_doc
  validate :doc_validations, on: :create


  def parse_doc
    byebug
    # If directly uploaded
    unless self.doc_contents.nil? || self.doc_contents[/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/] == ''
      content_type = self.doc_contents[/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
      content_type = content_type[/\b(?!.*\/).*/]
      contents = self.doc_contents.sub /data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = self.doc_name || 'doc_' + Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/images/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      self.doc.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)
      FileUtils.rm("#{Rails.root}/tmp/images/#{filename}")
    end
  end

  private

  def doc_validations
    if self.doc_contents.nil?
      errors.add(:base, I18n.t('errors.documents.file_required'))
    end
  end
end
