require "yaml"
require "mysql"

module Base
  abstract class Model

    def self.connection
      connection = nil

      yaml_file = File.read("#{__DIR__}/../../config/database.yml")
      yaml = YAML.load(yaml_file)
      if yaml.is_a?(Hash(YAML::Type, YAML::Type))
        settings = yaml[Base::App.settings.environment]
        if settings.is_a?(Hash(YAML::Type, YAML::Type))
          if settings["host"]
            host = settings["host"]
          end
          if settings["username"]
            username = settings["username"]
          end
          if settings["password"]
            password = settings["password"]
          end
          if settings["database"]
            database = settings["database"]
          end
          if settings["port"]
            port = settings["port"]
            if port.is_a?(String)
              port = port.to_u16
            end
          end
        end
      end
      
      if host.is_a?(String) &&
         username.is_a?(String) && 
         password.is_a?(String) &&
         database.is_a?(String) &&
         port.is_a?(UInt16)
          connection = MySQL.connect(host, username, password, database, port, nil)
      end
      
      return connection
    end

    def self.select(query, params)
      rows = [] of self
      conn = self.connection
      if conn
        begin
          results = MySQL::Query.new(query, params).run(conn)
          if results
            results.each do |result|
              rows << make(result)
            end
          end
        ensure
          conn.close
        end
      end
      return rows
    end

    def self.select_one(query, params)
      row = nil
      conn = self.connection
      if conn
        begin
          results = MySQL::Query.new(query, params).run(conn)
          if results
            row = make(results[0])
          end
        ensure
          conn.close
        end
      end
      return row
    end

    def insert(query, params)
      conn = Base::Model.connection
      if conn
        begin
          MySQL::Query.new(query, params).run(conn)
          results = conn.query(%{SELECT LAST_INSERT_ID() })
                                 
          if results
            id = results[0][0]
          end
        ensure
          conn.close
        end
      end
      return id
    end

    def update(query, params)
      conn = Base::Model.connection
      if conn
        begin
          MySQL::Query.new(query, params).run(conn)
        ensure
          conn.close
        end
      end
      return true
    end

    def delete(query, params)
      conn = Base::Model.connection
      if conn
        begin
          if id
            MySQL::Query.new(query, params).run(conn)
          end
        ensure
          conn.close
        end
      end
      return true
    end

    abstract def make(results : Array)
    
  end
  
end
