# require 'rails_helper'

# describe "笔记模块", :type => :feature ,:js => true do
#   it '建立笔记'do
#    @tom = create(:user)
#    tom_password = @tom.password
#    tom_email = @tom.email
#    visit '/notes'
#    fill_in 'session[email]',:with =>  tom_email
#    fill_in 'session[password]',:with => tom_password
#    click_button('提交')
#    expect(page).to have_content('登出')
#    visit '/notes'
#    expect(page).to have_content('建立笔记')
#    click_button('建立笔记')
#    # Capybara.default_max_wait_time = 5
#    # Capybara.automatic_reload = true
#    # reload_page 
#    expect(find('.modal-dialog').find('.modal-header').find('.modal-title')).to have_content('记录笔记')
#    # expect(page).to have_content('记录笔记')
#    # fill_in 'note[title]',:with =>  'title1'
#    # fill_in 'note[content]',:with => 'content1'
#    # click_button('提交')
#   end

#   # it'删除笔记'do
#   # end

#   # it '修改笔记'do
#   # end
#   # 页面测试因为无法正常的启用capybara的js功能而中止
# end

