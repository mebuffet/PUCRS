#include "parser.hpp"
#include <cmath>
#include <algorithm>
#include <iomanip>

/**
 * \brief Splits the given string by space in a vector
 * \param str string to be splitted
 * \return A vector containing the the splitted line_
 */
std::vector<std::string> SplitBySpace(std::string str) {
	std::string buf;
	std::stringstream ss(str);
	std::vector<std::string> tokens;
	while (ss >> buf)
		tokens.push_back(buf);
	return tokens;
}

/**
 * \brief Constructor
 */
Parser::Parser() : clock_(0), clock_counter_(0), is_clock_calculated_(false) {
}

/**
 * \brief Adds the given module in the modules_ vector
 * \param module Module to be added to the modules_ vector
 */
void Parser::AddModule(Module module) {
	modules_.push_back(module);
}

/**
 * \brief Displays the report of the parsed data
 */
void Parser::ShowReport() {
	std::cout << "-########################################-" << std::endl;
	std::cout << "-###  Value Change Dump (VCD) Parser  ###-" << std::endl;
	std::cout << "-########################################-" << std::endl << std::endl;
	std::cout << "----------------------------------------------------------------------------" << std::endl;
	std::cout << "VCD File Path: " << vcd_file_path_ << std::endl;
	std::cout << "Simulation Date: " << simulation_date_ << std::endl;
	std::cout << "Version: " << version_ << std::endl;
	std::cout << "Clock frequency: " << clock_ << " Hz" << std::endl;
	std::cout << "----------------------------------------------------------------------------" << std::endl << std::endl;

	Signal factor;
	factor.SwitchingActivityCounter = -1;
	long double TotalDynamicPower = 0.0;
	long double Vdd = 1.0;
	long double Fclk = clock_;
	long double Cl = 0.001;
	long double Esw = 0.0;
	for (std::vector<Module>::iterator module = modules_.begin(); module != modules_.end(); ++module) {
		module->SwitchingActivity = 0;
		module->TotalSignals = 0;
		for (std::vector<Signal>::iterator signal = module->Signals.begin(); signal != module->Signals.end(); ++signal) {
			module->TotalSignals++;
			if ((signal->SwitchingActivityCounter > 0) && (signal->SwitchingActivityCounter > factor.SwitchingActivityCounter)) {
				factor = *signal;
				factor.Factor = 1;
			}
			if (signal->SwitchingActivityCounter > 0)
				module->SwitchingActivity += signal->SwitchingActivityCounter;
		}
	}
	for (std::vector<Module>::iterator module = modules_.begin(); module != modules_.end(); ++module) {
		Esw = 0.0;
		std::cout << "Module: " << module->Name << std::endl;
		std::cout << "Signals count: " << module->SignalCounter << std::endl << std::endl;
		std::cout << std::setw(20) << std::left << "Name" << std::setw(30) << std::left << "Switching activity" << std::endl;
		std::cout << std::setw(20) << std::left << "----" << std::setw(30) << std::left << "------------------" << std::endl;

		for (std::vector<Signal>::iterator signal = module->Signals.begin(); signal != module->Signals.end(); ++signal) {
			std::cout << std::setw(20) << std::left << signal->Name << std::setw(30) << std::left << ((signal->SwitchingActivityCounter > 0) ? signal->SwitchingActivityCounter : 0) << std::endl;
			if (((signal->Name).compare(factor.Name) == 0) || (signal->SwitchingActivityCounter < 0))
				continue;

			signal->Factor = (signal->SwitchingActivityCounter * factor.Factor) / factor.SwitchingActivityCounter;
			Esw += signal->Factor;
		}
		Esw = Esw / module->TotalSignals;
		module->DynamicPower = (std::pow(Vdd,2) * Fclk * Cl * Esw) / 2;
		TotalDynamicPower += module->DynamicPower;
		std::cout << std::endl;
		std::cout << "Module Switching Activity: " << module->SwitchingActivity << std::endl;
		std::cout << "Module Dynamic Power: " << module->DynamicPower << std::endl << std::endl;
		std::cout << "----------------------------------------------------------------------------" << std::endl;
	}
	std::cout << factor.Name << "[" << factor.Symbol << "]" << " was the most changed signal, changing " << factor.SwitchingActivityCounter << " times" << std::endl;
	std::cout << "Total Dynamic Power: " << TotalDynamicPower << std::endl;
	std::cout << "--------End report--------" << std::endl;
}

long double Parser::GetTimeScale() const {
	long double scale = 1.0;
	if (time_scale_.compare("1ns") == 0)
		scale = 1e-9;
	else if (time_scale_.compare("1us") == 0)
		scale = 1e-6;
	else if (time_scale_.compare("1ms") == 0)
		scale = 1e-3;
	return scale;
}

/**
 * \brief Calculates the clock frequency 
 */
void Parser::CalculeClockFrequency() {
	if ((line_.size() > 0) && (line_.at(0) == '#')) { //isn't reset time
		if ((clock_counter_ > 0) && (clock_counter_ < 3)) {
			std::string numberStr = line_.substr(1, std::string::npos);
			if (clock_counter_ == 1)
				std::stringstream(numberStr) >> clock_start_;
			else if (clock_counter_ == 2) {
				std::stringstream(numberStr) >> clock_end_;
				long double period = 2 * (clock_end_ - clock_start_);
				clock_ = 1.0 / (period*GetTimeScale());
				is_clock_calculated_ = true;
			}
		}
		clock_counter_++;
	}
}

void Parser::RemoveTabFromString(std::string& str) const {
	str.erase(std::remove(str.begin(), str.end(), '\t'), str.end());
}

/**
 * \brief Parses the Date when the simulation was executed
 */
void Parser::ParseDate() {
	if (line_.find("$date") != std::string::npos) {
		while (getline(vcd_file_, line_)) {
			if (line_.find(":") != std::string::npos) {
				if (line_.find('\t') != std::string::npos) {
					simulation_date_ = line_;
					RemoveTabFromString(simulation_date_);
				}
				else
					simulation_date_ = line_;
				break;
			}
		}
	}
}


/**
 * \brief Parses the Simulation tool version
 */
void Parser::ParseVersion() {
	if (line_.find("$version") != std::string::npos) {
		while (getline(vcd_file_, line_)) {
			if (line_.find("Version") != std::string::npos) {
				if (line_.find('\t') != std::string::npos) {
					version_ = line_;
					RemoveTabFromString(version_);
				}
				else
					version_ = line_;
				break;
			}
		}
	}
}


/**
 * \brief Parses the time scale used for the simulation
 */
void Parser::ParseTimeScale() {
	if(line_.find("$timescale") != std::string::npos) {
		while (getline(vcd_file_, line_)) {
			if ((line_.find("1") != std::string::npos) || (line_.find("s") != std::string::npos)) {
				if (line_.find('\t') != std::string::npos) {
					time_scale_ = line_;
					RemoveTabFromString(time_scale_);
				}
				else
					time_scale_ = line_;
				break;
			}
		}
	}
}

/**
 * \brief Parses the provide .vcd file
 * \param vcdFilePath Full path of .vcd file
 * \return true whether the parsing was succesful else false
 */
bool Parser::Parse(std::string vcdFilePath) {
	bool result = false;
	vcd_file_.open(vcdFilePath.c_str());
	if (vcd_file_.is_open()) {
		vcd_file_path_ = vcdFilePath;
		while (getline(vcd_file_, line_)) {
			ParseDate();
			ParseVersion();
			ParseTimeScale();
			if (line_.find("$scope") != std::string::npos) {
				std::vector<std::string> splittedLine = SplitBySpace(line_);
				Module module;
				module.Name = splittedLine[2];
				while (getline(vcd_file_, line_)) {
					if (line_.find("$var") != std::string::npos) {
						Signal signal;
						signal.SwitchingActivityCounter = -1;
						std::vector<std::string> splittedLineSignal = SplitBySpace(line_);
						signal.Symbol = splittedLineSignal[3];
						if (splittedLineSignal.size() == 6)
							signal.Name = splittedLineSignal[4];
						else
							signal.Name = splittedLineSignal[4] + ' ' + splittedLineSignal[5];
						module.Signals.push_back(signal);
					}
					else
						break;
				}
				AddModule(module);
			}
			else if (line_.find("$dumpvars") != std::string::npos) {
				char switchingActivitySignals[SwitchingActivitySignalsSize] = { '0', '1', 'z' };
				bool foundSwitchingActivity = false;
				while (getline(vcd_file_, line_)) {
					if (!IsClockCalculated()) 
						CalculeClockFrequency();
					if ((line_[0] == '0') || (line_[0] == '1') || (line_[0] == 'z')) {
						foundSwitchingActivity = false;
						for (std::vector<Module>::iterator modulesIterator = modules_.begin(); modulesIterator != modules_.end() && !foundSwitchingActivity; ++modulesIterator) {
							for (std::vector<Signal>::iterator signalsIterator = modulesIterator->Signals.begin(); signalsIterator != modulesIterator->Signals.end() && !foundSwitchingActivity; ++signalsIterator) {
								for (unsigned i = 0; i < SwitchingActivitySignalsSize && !foundSwitchingActivity; i++) {
									std::string lineSubStr = line_.substr(1, line_.size());
									if (lineSubStr == signalsIterator->Symbol) {
										char currentSignalActivity = ' ';
										if (line_[0] == '0')
											currentSignalActivity = '0';
										else if (line_[0] == '1')
											currentSignalActivity = '1';
										else if (line_[0] == 'z')
											currentSignalActivity = 'z';
										if (signalsIterator->SwitchingActivityCounter == -1) {
											signalsIterator->SwitchingActivityCounter++;
											signalsIterator->CurrentActivity = currentSignalActivity;
											foundSwitchingActivity = true;
										}
										else {
											if (signalsIterator->CurrentActivity != switchingActivitySignals[i]) {
												signalsIterator->SwitchingActivityCounter++;
												signalsIterator->CurrentActivity = currentSignalActivity;
												foundSwitchingActivity = true;
											}
											else
												foundSwitchingActivity = false;
										}
									}
									else
										foundSwitchingActivity = false;
								}
							}
						}
					}
				}
			}
		}
		vcd_file_.close();
		CalculateSignalCounter();
		result = true;
	}
	return result;
}

void Parser::CalculateSignalCounter() {
	for (std::vector<Module>::iterator module = modules_.begin(); module != modules_.end(); ++module) {
		unsigned signalCounter = 0;
		Signal previousSignal = module->Signals[0];
		for (std::vector<Signal>::iterator it = module->Signals.begin(); it != module->Signals.end(); ++it) {	
			if (signalCounter == 0)
				signalCounter++;
			else {
				if (it->Name.find(" ") != std::string::npos) {
					std::string signalName = SplitBySpace(it->Name)[0];
					if (previousSignal.Name.find(" ") != std::string::npos) {
						std::string previossignalName = SplitBySpace(previousSignal.Name)[0];
						if (previossignalName.compare(signalName) != 0)
							signalCounter++;
					}
					else
						signalCounter++;
				}					
				else
					signalCounter++;
			}
			previousSignal = *it;
		}
		module->SignalCounter = signalCounter;
	}
}
