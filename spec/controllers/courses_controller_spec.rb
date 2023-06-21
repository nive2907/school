require "rails_helper"

RSpec.describe CoursesController do
  before(:all) do
    @school = School.create(name: 'test')
    @school_admin_role = Role.create(name: 'School Admin')
    @student_role = Role.create(name: 'Student')
    @school_admin = SchoolAdmin.create(name: 'rahul', role_id: @school_admin_role.id)
    @student = Student.create(name: 'rajesh', role_id: @student_role.id, school_id: @school.id)
  end

  after(:all) do
    @school.destroy
    @student_role.destroy
    @school_admin_role.destroy
    @student.destroy
    @school_admin.destroy
  end

  it 'should throw error if user without create_enrollment privilege creates course' do
    params = { course: { name: 'Course1', school_id: @school.id }, user_id: @student.id, user_type: 'Student' }
    expect{ post :create, params: params, format: :json }.to raise_error(::AppErrors::Unauthorized)
  end

  it 'should create enrollment when school admin creates course' do
    params = { course: { name: 'Course1', school_id: @school.id }, user_id: @school_admin.id, user_type: 'SchoolAdmin' }
    post :create, params: params, format: :json
    expect(Course.last.name).to eq 'Course1'
  end
end
