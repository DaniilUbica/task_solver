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
			std::pair<QString, QString> data_elem = { key_value[0], key_value[1] };
			m_data.insert(data_elem);
		}
	}
}

void TaskSolver::solveTask(uint task_number) {
	float result1 = 0.0;
	float result2 = 0.0;
	auto keys = InputKeysHolder::instance();

	if (task_number == 1) {
		float num = m_data[keys->num()].toFloat();
		float failed_num = m_data[keys->failed()].toFloat();

		result1 = successProbability(num, failed_num);
		result2 = failureProbability(num, failed_num);
	}

	if (task_number == 2) {
		float num = m_data[keys->num()].toFloat();
		float failed_num = m_data[keys->failed()].toFloat();
		float t1 = m_data[keys->interval_start()].toFloat();
		float t2 = m_data[keys->interval_end()].toFloat();
		float interval_failed_num = m_data[keys->interval_failed()].toFloat();

		result1 = failureRate(num, t1, t2, interval_failed_num);
		result2 = failureIntensivity(num, t1, t2, interval_failed_num, failed_num);
	}

	if (task_number == 4) {
		float num = m_data[keys->num()].toFloat();
		QString times = m_data[keys->detail_work_times()];
		std::vector<float> times_f;

		for (auto time : times.split('-')) {
			times_f.push_back(time.toFloat());
		}

		float sum = std::accumulate(times_f.begin(), times_f.end(), 0.0);

		result1 = sum / num;
	}

	if (result1 > 0.0 && result2 > 0.0) {
		m_resultValues = QString::number(result1) + " & " + QString::number(result2);
	}
	else if (result1 > 0.0) {
		m_resultValues = QString::number(result1);
	}
	else {
		m_resultValues = QString("Error in values input!");
	}
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