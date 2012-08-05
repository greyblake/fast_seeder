require 'spec_helper'

describe FastSeeder do
  let(:idiot_attrs) {{ :name => "The Idiot"           , :published_in => 1868 }}
  let(:crime_attrs) {{ :name => "Crime and Punishment", :published_in => 1866 }}
  let(:idiot_book) { Book.where(idiot_attrs).first }
  let(:crime_book) { Book.where(crime_attrs).first }


  describe '.seed_csv!' do
    before do
      file = Tempfile.new('books')
      file.write(
        "Crime and Punishment,1866\n" \
        "The Idiot,1868\n"
      )
      file.close

      seeds_path, @csv_file = File.dirname(file.path), File.basename(file.path)
      FastSeeder.stub(:seeds_path => seeds_path)
    end


    context 'without default values' do
      before { FastSeeder.seed_csv!(Book, @csv_file, :name, :published_in) }

      it 'populates only with CSV data' do
        Book.count.should == 2
        idiot_book.should_not be_nil
        crime_book.should_not be_nil
      end

      it 'populates timestamps with now' do
        idiot_book.created_at.should be_within(1.minute).of(Time.zone.now)
        idiot_book.updated_at.should be_within(1.minute).of(Time.zone.now)
      end
    end

    context 'with default values' do
      it 'populates with CSV and default values' do
        FastSeeder.seed_csv!(Book, @csv_file, :name, :published_in, :author =>  "Dostoyevsky F.M.")

        idiot_book.author.should == "Dostoyevsky F.M."
        crime_book.author.should == "Dostoyevsky F.M."
      end
    end

    context 'with timestamps as default values' do
      it 'populates with timestamps as well' do
        created_time = Time.zone.parse("2010-01-01 00:00:00")
        updated_time = Time.zone.parse("2011-05-12 04:30:00")

        FastSeeder.seed_csv!(Book, @csv_file, :name, :published_in, :created_at => created_time, :updated_at => updated_time)

        idiot_book.created_at.should == created_time
        idiot_book.updated_at.should == updated_time
      end
    end

    context 'when model has no timestamps' do
      it 'populates as expected' do
        BookWithoutTimestamps.column_names.should_not include('created_at')
        BookWithoutTimestamps.column_names.should_not include('updated_at')

        FastSeeder.seed_csv!(BookWithoutTimestamps, @csv_file, :name, :published_in, :author =>  "Dostoyevsky F.M.")

        BookWithoutTimestamps.count.should == 2
        BookWithoutTimestamps.where(idiot_attrs).should_not be_empty
        BookWithoutTimestamps.where(crime_attrs).should_not be_empty
      end
    end
  end


  describe '.seed!' do
    context 'without default values' do
      it 'populates data' do
        FastSeeder.seed!(Book, :name, :published_in) do
          record "Crime and Punishment", 1866
          record "The Idiot"           , 1868
        end
        Book.count.should == 2
        idiot_book.should_not be_nil
        crime_book.should_not be_nil
      end
    end

    context 'with default values' do
      it 'populates with default values' do
        FastSeeder.seed!(Book, :name, :published_in, :author => "Dostoyevsky F.M.") do
          record "Crime and Punishment", 1866
          record "The Idiot"           , 1868
        end
        Book.count.should == 2
        idiot_book.author.should == "Dostoyevsky F.M."
        crime_book.author.should == "Dostoyevsky F.M."
      end
    end
  end
end
