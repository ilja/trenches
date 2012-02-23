When /^I go to my project's page$/ do
  click_link 'My new projec'
end

When /^I go to its backlog page$/ do
  find(:xpath, "//a[@rel='project-backlog']").click
end

Then /^I should see the product backlog$/ do
  page.should have_content 'Product Backlog'
end