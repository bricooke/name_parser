class NameParser
  VERSION = '0.1.2'
  
  attr_reader :first_name, :last_name, :middle_name, :prefix, :suffix
  
  PREFIXES = [/^mrs[\.]?/i, /^mr[\.]?/i, /^ms[\.]?/i, /^miss/i, /^mister/i, /^dr[\.]?/i, /^mr[\.]? and mrs[\.]?/i, /^mrs[\.]? and mr[\.]?/i]
  SUFFIXES = [/,?\s*jr[\.]?$/i, /,?\s*sr[\.]?$/i, /,?\s*iii$/i, /,?\s*iv$/i, /,?\s*v$/i, /,?\s*phd$/i]
  LAST_NAME_PREFIXES = [/de la /i]
  
  def initialize(string)
    @initial_string = string
    @first_name = @last_name = @middle_name = @prefix = @suffix = ""
    @working_string = string
    
    remove_current_resident
    find_prefix
    find_suffix
    find_first_name
    find_last_name
    find_middle_name
  end
  
  def remove_current_resident
    @working_string = @working_string.gsub(/(or)?\s*current resident/i, "")
  end
  
  def find_prefix
    PREFIXES.each do |prefix|
      @prefix = prefix.match(@working_string)[0] rescue ""
      break unless @prefix.empty?
    end
    @working_string = @working_string.gsub(@prefix, "").strip
  end
  
  def find_first_name
    @first_name = @working_string.split(" ")[0] || ""
    @working_string = @working_string.gsub(@first_name, "").strip
  end
  
  def find_last_name
    @last_name = @working_string.split(" ")[-1] || ""
    @working_string = @working_string.gsub(@last_name, "").strip
  end
  
  def find_middle_name
    @middle_name = @working_string.strip
  end
  
  def find_suffix
    SUFFIXES.each do |suffix|
      @suffix = suffix.match(@working_string)[0] rescue ""
      break unless @suffix.empty?
    end
    @working_string = @working_string.gsub(@suffix, "").strip
    @suffix = @suffix.gsub(/,?\s*/, "").strip
  end
end