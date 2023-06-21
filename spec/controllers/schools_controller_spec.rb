require 'rails_helper'

RSpec.describe SchoolsController do
  before(:all) do
    @school_admin_role = Role.create(name: 'School Admin')
    @admin_role = Role.create(name: 'Admin')
		@school_admin = SchoolAdmin.create(name: 'rahul', role_id: @school_admin_role.id)
    @admin = Admin.create(name: 'rajesh', role_id: @admin_role.id)
  end

  after(:all) do
    @admin_role.destroy
    @school_admin_role.destroy
    @admin.destroy
    @school_admin.destroy
  end

  it 'should allow admin to create school' do
    params = { school: { name: 'School Test' }, user_id: @admin.id, user_type: 'Admin' }
    post :create, params: params, format: :json
    expect(School.last.name).to eq 'School Test'
  end

	it 'should allow school admin to update school' do
		school = School.create(name: 'Old School')
		expect(school.name).to eq 'Old School'
    params = { id: school.id, school: { name: 'New School' }, user_id: @school_admin.id, user_type: 'SchoolAdmin'}
		put :update, params: params, format: :json
    expect(School.last.name).to eq 'New School'
  end
end
