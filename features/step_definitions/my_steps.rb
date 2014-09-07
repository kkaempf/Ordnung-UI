#
# extract button label from 'value' attribute
#
Then /^I should see a button with "([^"]*)"$/ do |arg1| #"
  find(:xpath, "//input[@value=\"#{arg1}\"]")
end
  
Then /^I should see the contents of directory "([^"]*)"$/ do |arg1| #"
  Dir.open(arg1) do |d|
    d.each do |dir|
      next if dir == "."
      next if dir == ".."
      if page.respond_to? :should
	expect(page).to have_content(dir)
      else
	assert page.has_content?(dir)
      end
    end
  end
end
  
Then(/^I should see many thumbnails$/) do
  expect(page).to have_selector(".thumbnail")
end
    