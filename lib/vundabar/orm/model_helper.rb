module Vundabar
  module ModelHelper
    def self.included(base)
      base.extend ClassMethods
    end

    def update(attributes)
      table = self.class.table_name
      query = "UPDATE #{table} SET #{update_placeholders(attributes)}"\
      " WHERE id= ?"
      Database.execute_query(query, update_values(attributes))
    end

    def destroy
      table = self.class.table_name
      Database.execute_query "DELETE FROM #{table} WHERE id= ?", id
    end

    def save
      table = self.class.table_name
      query = if id
                "UPDATE #{table} SET #{update_placeholders} WHERE id = ?"
              else
                "INSERT INTO #{table} (#{table_columns}) VALUES "\
                "(#{record_placeholders})"
              end
      values = id ? record_values << send("id") : record_values
      Database.execute_query query, values
    end

    alias save! save
    module ClassMethods
      def all
        query = "SELECT * FROM #{table_name} "\
          "ORDER BY id DESC"
        result = Database.execute_query query
        result.map { |row| get_model_object(row) }
      end

      def create(attributes)
        object = new(attributes)
        object.save
        id = Database.execute_query "SELECT last_insert_rowid()"
        object.id = id.first.first
        object
      end

      def count
        result = Database.execute_query "SELECT COUNT(*) FROM #{table_name}"
        result.first.first
      end

      [%w(last DESC), %w(first ASC)].each do |method_name_and_order|
        define_method((method_name_and_order[0]).to_s.to_sym) do
          query = "SELECT * FROM #{table_name} ORDER BY "\
          "id #{method_name_and_order[1]} LIMIT 1"
          row = Database.execute_query query
          get_model_object(row.first) unless row.empty?
        end
      end

      def find(id)
        query = "SELECT * FROM #{table_name} "\
        "WHERE id= ?"
        row = Database.execute_query(query, id).first
        get_model_object(row) if row
      end

      def destroy(id)
        Database.execute_query "DELETE FROM #{table_name} WHERE id= ?", id
      end

      def destroy_all
        Database.execute_query "DELETE FROM #{table_name}"
      end

      def where(querry_string, value)
        data = Database.execute_query "SELECT * FROM "\
        "#{table_name} WHERE #{querry_string}", value
        data.map { |row| get_model_object(row) }
      end
    end
  end
end
