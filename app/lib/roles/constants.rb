module Roles
    module Constants
        DEFAULT_ROLES = {
            admin: 'Admin',
            school_admin: 'School Admin',
            student: 'Student'
        }

        PRIVILEGES = {
            create_school: 1,
            update_school: 2,
            create_school_admin: 3,
            create_course: 4,
            create_batch: 5,
            add_to_batch: 6,
            create_enrollment: 7,
            update_enrollment: 8,
            view_students: 9
        }

        ADMIN_SPECIFIC_PRIVILEGES = [:create_school, :create_school_admin]
        SCHOOL_ADMIN_SPECIFIC_PRIVILEGES = [:update_school, :create_course, :create_batch, :add_to_batch, :update_enrollment]
        STUDENT_SPECIFIC_PRIVILEGES = [:create_enrollment, :view_students]
        ADMIN_PRIVILEGES = ADMIN_SPECIFIC_PRIVILEGES | SCHOOL_ADMIN_SPECIFIC_PRIVILEGES | STUDENT_SPECIFIC_PRIVILEGES
        
        ROLE_PRIVILEGE_MAPPING = {
            admin: ADMIN_PRIVILEGES,
            school_admin: SCHOOL_ADMIN_SPECIFIC_PRIVILEGES,
            student: STUDENT_SPECIFIC_PRIVILEGES 
        }
    end
end