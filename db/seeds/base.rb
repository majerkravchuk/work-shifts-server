module Seeds
  class Base
    def log(record)
      puts "=== #{record.class.name} successfully seeded:"
      puts JSON.pretty_generate(record.attributes)
      puts "=== #{record.class.name} ==="
      puts ''
    end
  end
end
