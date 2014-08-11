require  'faker'
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
  @administrator_1 = User.create  name: 'Anton Yordnaov',
    email: 'anton.yordanov@droxic.com',
    password: 'password',
    password_confirmation: 'password',
    organization: 'Droxic'

  @administrator_1.add_role(@admin_role.name)

  @administrator_2 = User.create  name: 'Robert Ivanov',
    email: 'robert.ivanov@droxic.com',
    password: 'password',
    password_confirmation: 'password',
    organization: 'Droxic'

  @administrator_2.add_role('administrator')

  @regular_user = User.create name: 'Anton Yordnaov GMAIL',
    email: 'anton.yordanov@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    organization: 'Droxic'

  @regular_user.add_role(@regular_role.name)
end


seed "Create Building Blocks" do
  BuildingBlock.create title: Faker::Company.name,
    owner_id: @regular_user.id
  BuildingBlock.create title: Faker::Company.name,
    owner_id: @regular_user.id
end
