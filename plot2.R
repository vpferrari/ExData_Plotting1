# plot2.R: Global Active Power plot

# download the file and place it in the working directory

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata_data_household_power_consumption.zip"
datafile <- "household_power_consumption.txt"

if(!file.exists(zipfile) && !file.exists(datafile)){
    print("Downloading data...")
    download.file(fileURL, zipfile, method = "curl")
    print("Done.")
    # unzip the file into working directory
    print("Unzip data file...")
    unzip(zipfile)
    print("Done.")
}

# load the data into memory
power_df <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?", 
                       colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# Converting character to date in 'Date'
power_df$Date <- as.Date(power_df$Date, format = "%d/%m/%Y")
power_df$temp <- paste(power_df$Date, power_df$Time)
power_df$Time <- strptime(power_df$temp, format = "%Y-%m-%d %H:%M:%S")

# Subsetting dates
subset_data <- subset(power_df, power_df$Date == as.Date("2007-02-01") | power_df$Date == as.Date("2007-02-02"))

# Plot
png("plot2.png", width = 480, height = 480, units = "px")
with(subset_data, plot(subset_data$Time, subset_data$Global_active_power, type = "l", main = "",
                       ylab = "Global Active Power (kilowatts)", xlab = "")) 
dev.off()

print("Done. File plot2.png created.")
