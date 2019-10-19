#pragma once

#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include <fstream>

const unsigned SwitchingActivitySignalsSize = 3;

struct Signal {
	std::string Name;
	std::string Symbol;
	int SwitchingActivityCounter;
	long double Factor;
	char CurrentActivity;
};

struct Module {
	std::string Name;
	std::vector<Signal> Signals;
	unsigned TotalSignals;
	long double DynamicPower;
	unsigned SwitchingActivity;
	unsigned SignalCounter;
};

class Parser {
private:
	std::string simulation_date_;
	std::string version_;
	std::string time_scale_;
	std::vector<Module> modules_;
	long double clock_;
	unsigned clock_start_;
	unsigned clock_end_;
	unsigned clock_counter_;
	bool is_clock_calculated_;
	std::ifstream vcd_file_;
	std::string line_;
	std::string vcd_file_path_;

	void AddModule(Module module);
	long double GetTimeScale() const;
	void CalculeClockFrequency();
	void ParseDate();
	void ParseVersion();
	void ParseTimeScale();
	void CalculateSignalCounter();
	
	void RemoveTabFromString(std::string &str) const;

	inline std::string GetSimulationDate() const {
		return simulation_date_;
	}

	inline std::string GetVersion() const {
		return version_;
	}

	inline bool IsClockCalculated() const {
		return is_clock_calculated_;
	}

	inline std::vector<Module> GetModules() const {
		return modules_;
	}

public:
	bool Parse(std::string vcdFilePath);
	Parser();
	void ShowReport();
};
