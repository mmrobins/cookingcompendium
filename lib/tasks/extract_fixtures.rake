desc ' Create YAML test fixtures from data in an existing database.
Defaults to development database. Set RAILS_ENV to override.'

task :extract_fixtures => :environment do
	sql = "SELECT * FROM %s"
	skip_tables = ["schema_info"]
	(ActiveRecord::Base.connection.tables - skip_tables).each do |table_name| 
		index = "000"
		File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w' ) do |file|
			data = ActiveRecord::Base.connection.select_all(sql % table_name)
			data.each do |record|
			  record.each do |key, value|
          if value =~ /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/
            t = value.scan(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/).to_s
            if t == "0000-00-00 00:00:00"
              t = "2007-01-20 00:00:00"
            end
            unless t.empty?
              diff = (Time.now - t.to_time).to_i
              if diff < 0
                sign = "+"
                diff = diff * -1
              else
                sign = "-"
              end
              record[key] = value.gsub(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/, "<%= Time.now #{sign} #{diff} %>")
            end
          end
          if value =~ /\d{4}-\d{2}-\d{2}$/
            d = value.scan(/\d{4}-\d{2}-\d{2}/).to_s
            if d == "0000-00-00"
              d = Date.today.to_s
            end
            unless d.empty?
              diff = (Date.today - d.to_s.to_date).to_i
              if diff < 0
                sign = "+"
                diff = diff * -1
              else
                sign = "-"
              end
              record[key] = value.gsub(/\d{4}-\d{2}-\d{2}/, "<%= Date.today #{sign} #{diff} %>")
            end
          end
        end
      end
			file.write data.inject({}) { |hash, record|
				hash["#{table_name}_#{index.succ!}"] = record
				hash
			}.to_yaml
		end
	end
end