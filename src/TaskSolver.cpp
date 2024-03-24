#include "./include/TaskSolver.h"
#include "./include/InputKeysHolder.h"

TaskSolver::TaskSolver(QObject* parent) : QObject(parent) {
}

void TaskSolver::setInputData(const QString& data) {
	auto words = data.split(' ');

	m_data.clear();
	for (auto word : words) {
		auto key_value = word.split(':');
		if (key_value.size() > 1) {
			std::pair<QString, float> data_elem = { key_value[0], key_value[1].toFloat() };
			m_data.insert(data_elem);
		}
	}
}

void TaskSolver::solveTask(uint task_number) {
	float result1 = -1.0;
	float result2 = -1.0;
	auto keys = InputKeysHolder::instance();

	if (task_number == 1) {
		float num = m_data[keys->num()];
		float failed_num = m_data[keys->failed()];

		result1 = successProbability(num, failed_num);
		result2 = failureProbability(num, failed_num);
	}

	if (task_number == 2) {
		float num = m_data[keys->num()];
		float failed_num = m_data[keys->failed()];
		auto t1 = m_data[keys->interval_start()];
		auto t2 = m_data[keys->interval_end()];
		auto interval_failed_num = m_data[keys->interval_failed()];

		result1 = failureRate(num, t1, t2, interval_failed_num);
		result2 = failureIntensivity(num, t1, t2, interval_failed_num, failed_num);
	}

	m_resultValues = QString::number(result1) + " & " + QString::number(result2);
}

float TaskSolver::successProbability(float num, float failed_num) {
	if (num < failed_num) {
		return -1.0;
	}

	return (num - failed_num) / num;
}

float TaskSolver::failureProbability(float num, float failed_num) {
	if (num < failed_num) {
		return -1.0;
	}

	return failed_num / num;
}

float TaskSolver::failureRate(float num, float t1, float t2, float interval_failure_num) {
	int delta_time = std::max(t1, t2) - std::min(t1, t2);

	return interval_failure_num / (num * delta_time);
}

float TaskSolver::failureIntensivity(float num, float t1, float t2, float interval_failure_num, float failed_num) {
	int delta_time = std::max(t1, t2) - std::min(t1, t2);

	return interval_failure_num / (delta_time * (num - failed_num));
}

float TaskSolver::mtbf(float num, std::vector<float>& mtbf_details) {
	float sum = std::accumulate(mtbf_details.begin(), mtbf_details.end(), 0.0);
	return sum / num;
}