require File.expand_path(File.dirname(__FILE__) + '/../teststrap')
require 'digest_mailer'

context "DigestMailer mail" do
  setup { DigestMailer.new.mail }

  asserts(:to).equals(['my@email.not'])
  asserts(:from).equals(['fake@email.not'])
  asserts(:subject).equals("#{Time.now.strftime('%D')} digest")
  asserts(:delivery_method).kind_of(Mail::Sendmail)

  context "body" do
    setup { topic.body }

    YAML.load_file('data/digest.yml').each do |commits|
      asserts(:raw_source).matches(/#{commits.first.capitalize} application/)
      commits.last.each do |commit_hash|
        asserts(:raw_source).matches(/Commit by #{commit_hash['author']} \[#{commit_hash['sha']}\]/)
        asserts(:raw_source).matches(/'#{commit_hash['message']}' has #{commit_hash['status']}ed/)
      end
    end
  end

end