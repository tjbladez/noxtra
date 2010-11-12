require File.join(File.dirname(__FILE__), 'config', 'boot')

class DigestMailer
  attr_accessor :mail

  def mail
    @mail ||= prepare_mail
  end

  def send
    mail.deliver if ENV['APP_ENV'] != 'test'
  end

private
  def prepare_body
    body = "Following commits were received and ran today:"
    YAML.load_file('data/digest.yml').each do |commits|
      body << "\n#{commits.first.capitalize} application:\n"
      commits.last.each do |commit_hash|
        body << "#{commit_hash['time']}: Commit by #{commit_hash['author']} [#{commit_hash['sha']}] with commit message '#{commit_hash['message']}' has #{commit_hash['status']}ed\n"
      end
    end
    body
  end

  def prepare_mail
    Mail.new.tap do |mail|
      mail.from "my@email.not"
      mail.to 'fake@email.not'
      mail.subject "#{Time.now.strftime('%D')} digest"
      mail.delivery_method :sendmail
      mail.body prepare_body
    end
  end

end