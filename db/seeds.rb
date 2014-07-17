def purge
  User.destroy_all
  Role.destroy_all
end

def seed message, &block
  print message
  yield
  puts '....Done!'
end

purge

seed "Create Roles" do
  @admin_role = Role.create(name: 'administrator')
  @regular_role = Role.create(name: 'regular')
end

seed "Create Users" do
  administrator = User.create  name: 'Anton Yordnaov',
    email: 'anton.yordanov@droxic.com',
    password: 'password',
    password_confirmation: 'password',
    organization: 'Droxic'

  administrator.add_role('administrator')

  regular_user = User.create name: 'Anton Yordnaov GMAIL',
    email: 'anton.yordanov@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    organization: 'Droxic'

  regular_user.add_role('regular_user')
end
