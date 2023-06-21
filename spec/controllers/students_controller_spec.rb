require 'rails_helper'

RSpec.describe StudentsController do
  before(:all) do
		@school = School.create(name: 'test')
		@batch = Batch.create(start_date: DateTime.now, end_date: DateTime.now + 1.year, school_id: @school.id)
    @school_admin_role = Role.create(name: 'School Admin')
		@school_admin = SchoolAdmin.create(name: 'rahul', role_id: @school_admin_role.id)
		@student_role = Role.create(name: 'Student')
    @student = Student.create(name: 'rahul', school_id: @school.id, role_id: @student_role.id)
  end

  after(:all) do
		@school.destroy
    @school_admin_role.destroy
		@student.destroy
  end

  it 'should allow school admin to add student to batch' do
    params = { id: @student.id, student: { batch_id: @batch.id }, user_id: @school_admin.id, user_type: 'SchoolAdmin' }
    put :add_to_batch, params: params, format: :json
		@student.reload
    expect(@student.batch_id).to eq @batch.id
  end
end
