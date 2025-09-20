require "./spec_helper"

describe CNPJ do
  describe "#value" do
    it "returns value" do
      cnpj = CNPJ.new("UP.FVU.R5W/0001-07")
      cnpj.value.should eq "UP.FVU.R5W/0001-07"

      cnpj = CNPJ.new("UPFVUR5W000107")
      cnpj.value.should eq "UPFVUR5W000107"
    end
  end

  describe "#to_s" do
    it "delegates to @value" do
      cnpj = CNPJ.new("UP.FVU.R5W/0001-07")
      cnpj.to_s.should eq "UP.FVU.R5W/0001-07"

      output = String.build { |io| cnpj.to_s(io) }
      output.should eq "UP.FVU.R5W/0001-07"
    end
  end

  describe "#initialize" do
    INVALID_VALUES.each do |value|
      context "with invalid value: #{value}" do
        it "raises CNPJ::InvalidValueError" do
          expect_raises(CNPJ::InvalidValueError, "Invalid CNPJ value") do
            CNPJ.new(value)
          end
        end
      end
    end

    VALID_VALUES.each do |value|
      context "with valid value: #{value}" do
        it "returns a CNPJ object" do
          cnpj = CNPJ.new(value)
          cnpj.class.should eq CNPJ
        end
      end
    end
  end

  describe ".parse" do
    INVALID_VALUES.each do |value|
      context "with invalid value: #{value}" do
        it "returns nil" do
          expect_raises(CNPJ::InvalidValueError, "Invalid CNPJ value") do
            cnpj = CNPJ.new(value)
            cnpj.should be_nil
          end
        end
      end
    end

    VALID_VALUES.each do |value|
      context "with valid value: #{value}" do
        it "returns a CNPJ object" do
          cnpj = CNPJ.new(value)
          cnpj.class.should eq CNPJ
        end
      end
    end
  end

  describe "#formatted" do
    it "returns formatted CNPJ" do
      cnpj = CNPJ.new("7B.N1F.Y9N/0001-98")
      cnpj.formatted.should eq "7B.N1F.Y9N/0001-98"

      cnpj = CNPJ.new("VCZ83T1R000106")
      cnpj.formatted.should eq "VC.Z83.T1R/0001-06"
    end
  end

  describe "#unformatted" do
    it "returns unformatted CNPJ" do
      cnpj = CNPJ.new("7B.N1F.Y9N/0001-98")
      cnpj.unformatted.should eq "7BN1FY9N000198"

      cnpj = CNPJ.new("VCZ83T1R000106")
      cnpj.unformatted.should eq "VCZ83T1R000106"
    end
  end
end

private INVALID_VALUES = [
  "",
  "abc",
  "123",
  "ab.cde.fgh/ijkl-mn",
  "12.345.678/9012-34",
  "abcdefghijklmn",
  "12345678901234",
  "UP,FVU.R5W/0001-07",
  "UP.FVU.R5W-0001/07",
  " UP.FVU.R5W/0001-07 ",
  "UP FVU R5W 0001 07",
  "UP F#U R@W 0001 07",
  "11111111111111",
  "11.111.111/1111-11",
  "22222222222222",
  "33333333333333",
  "44444444444444",
  "55555555555555",
  "66666666666666",
  "77777777777777",
  "88888888888888",
  "99999999999999",
  "00000000000000",
  "12345678901234",
  # valid values with wrong format
  "UPFVU.R5W/0001-07",
  "UP.FVUR5W/0001-07",
  "UP.FVU.R5W0001-07",
  "UP.FVU.R5W/000107",
  "UPFVUR5W/0001-07",
  "UPFVU.R5W0001-07",
  "UPFVU.R5W/000107",
  "UP.FVUR5W0001-07",
  "UP.FVUR5W/000107",
  "UP.FVU.R5W000107",
  "UPFVUR5W0001-07",
  "UPFVUR5W/000107",
  "UP.FVUR5W000107",
  "UPFVU.R5W000107",
]

private VALID_VALUES = [
  "UP.FVU.R5W/0001-07",
  "UPFVUR5W000107",
  "VC.Z83.T1R/0001-06",
  "VCZ83T1R000106",
  "7B.N1F.Y9N/0001-98",
  "7BN1FY9N000198",
  "85.703.808/0001-98",
  "85703808000198",
  "24.485.147/0001-87",
  "24485147000187",
  "13.624.700/0001-07",
  "13624700000107",
]
