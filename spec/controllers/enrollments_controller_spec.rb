require 'rails_helper'

RSpec.describe EnrollmentsController do
  before(:all) do
    @school = School.create(name: 'test')
    @school_admin_role = Role.create(name: 'School Admin')
    @student_role = Role.create(name: 'Student')
    @school_admin = SchoolAdmin.create(name: 'rahul', role_id: @school_admin_role.id)
    @student = Student.create(name: 'rahul', school_id: @school.id, role_id: @student_role.id)
    @batch = Batch.create(start_date: DateTime.now, end_date: DateTime.now + 1.year, school_id: @school.id)
  end

  after(:all) do
    @school.destroy
    @student_role.destroy
    @student.destroy
    @school_admin_role.destroy
    @school_admin.destroy
  end

  it 'should allow student to create enrollment' do
    params = { enrollment: { batch_id: @batch.id, school_id: @school.id, user_id: @student.id }, user_id: @student.id, user_type: 'Student' }
    post :create, params: params, format: :json
    expect(Enrollment.last.batch_id).to eq @batch.id
  end

  it 'should allow school admin to approve/deny an enrollment' do 
    expect(@student.batch_id).to eq nil
    enrollment = Enrollment.create(school_id: @school.id, batch_id: @batch.id, user_id: @student.id)
    params = { id: enrollment.id, enrollment: { status: Enrollment::STATUS[:approved] }, user_id: @school_admin.id, user_type: 'SchoolAdmin' }
    put :approve, params: params, format: :json
    @student.reload
    expect(@student.batch_id).to eq @batch.id
  end
end
