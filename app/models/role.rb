class Role < ApplicationRecord
    include ::Roles::Constants

    has_many :user_roles
    has_many :students, through: :user_roles, source: :user, source_type: 'Student'
    has_many :admins, through: :user_roles, source: :user, source_type: 'Admin'
    has_many :school_admins, through: :user_roles, source: :user, source_type: 'SchoolAdmin'
    before_save :set_privilege

    # Creating a bitmask using | operator
    # Checking if privilege exists based on rule:
    # a & (a | b) = a
    def privilege?(name)
        (self.privileges.to_i & 2**PRIVILEGES[name.to_sym]) == 2**PRIVILEGES[name.to_sym]
    end

    def set_privilege
        privilege_arr = ROLE_PRIVILEGE_MAPPING[self.name.parameterize.underscore.to_sym]
        bitmask = 0
        privilege_arr.each do |value|
            bitmask |= 2**PRIVILEGES[value]
        end
        self.privileges = bitmask
    end
end
