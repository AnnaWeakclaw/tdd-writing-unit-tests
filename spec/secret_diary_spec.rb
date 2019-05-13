require_relative "../lib/secret_diary"

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  it "when locked refuses to be read" do
    fakeDiary = double("Diary")
    secretDiary = SecretDiary.new(fakeDiary)

    secretDiary.lock
    expect(secretDiary.read).to eq("Go away!")
  end

  it "when locked refuses to be written" do
    fakeDiary = double("Diary")
    secretDiary = SecretDiary.new(fakeDiary)
    secretDiary.lock
    expect(secretDiary.write("New message")).to eq("Go away!")
  end

  it "when unlocked gets read" do
    fakeDiary = double("Diary")
    allow(fakeDiary).to receive (:read)
    secretDiary = SecretDiary.new(fakeDiary)
    secretDiary.unlock
    expect(secretDiary.read).to eq(fakeDiary.read)
  end

  it "when unlocked gets written" do
    fakeDiary = double("Diary")
    allow(fakeDiary).to receive (:write)
    secretDiary = SecretDiary.new(fakeDiary)
    secretDiary.unlock
    expect(secretDiary.write("New message")).to eq(fakeDiary.write("Message"))
  end
end
