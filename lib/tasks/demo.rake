namespace :demo do
    desc "Seed fake links — usage: bin/rails demo:seed[100000]"
    task :seed, [ :count ] => :environment do |_t, args|
      count = (args[:count] || 100_000).to_i
      batch = 5_000

      puts "Seeding #{count} links in batches of #{batch}..."
      (count / batch).times do |i|
        rows = Array.new(batch) do |j|
          n = i * batch + j
          {
            original_url: "https://example.com/page/#{n}",
            short_code:   SecureRandom.alphanumeric(7),
            created_at:   Time.current,
            updated_at:   Time.current
          }
        end
        Link.insert_all(rows)   # one INSERT for 5,000 rows
        print "."
      end
      puts "\nDone. Link.count = #{Link.count}"
    end
  end
