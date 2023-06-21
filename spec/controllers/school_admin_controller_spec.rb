require 'rails_helper'

RSpec.describe SchoolAdminController do
  before(:all) do
    @admin_role = Role.create(name: 'Admin')
    @admin = Admin.create(name: 'rajesh')
		@school_admin_role = Role.create(name: 'School Admin')
    UserRole.create(user_id: @admin.id, user_type: 'Admin', role_id: @admin_role.id)
  end

  after(:all) do
    @admin_role.destroy
    @admin.destroy
  end

  it 'should allow admin to create school_admin' do
    params = { school_admin: { name: 'School Admin User', role_id: @school_admin_role.id }, user_id: @admin.id, user_type: 'Admin' }
    post :create, params: params, format: :json
    expect(SchoolAdmin.last.name).to eq 'School Admin User'
		expect(SchoolAdmin.last.role.name).to eq 'School Admin'
  end
end
