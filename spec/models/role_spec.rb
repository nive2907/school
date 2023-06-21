require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'test admin role' do
    before(:all) do
      @admin_role = Role.create(name: 'Admin')
    end

    after(:all) do
      @admin_role.destroy
    end

    it 'should have the create_school and create_school_admin privilege' do
      expect(@admin_role.privilege?(:create_school)).to eq true
      expect(@admin_role.privilege?(:create_school_admin)).to eq true
    end
  end

  context 'test school_admin role' do
    before(:all) do
      @role = Role.create(name: 'School Admin')
    end

    after(:all) do
      @role.destroy
    end

    it 'should have the create_course and create_batch privilege' do
      expect(@role.privilege?(:create_course)).to eq true
      expect(@role.privilege?(:create_batch)).to eq true
    end

    it 'should not have the create_school privilege' do
      expect(@role.privilege?(:create_school)).to eq false
    end
  end
end

