#pragma once

#include <QObject>
#include <memory>

class InputKeysHolder : public QObject {
	Q_OBJECT

public:
	static InputKeysHolder* instance();
	~InputKeysHolder() { delete m_instance; };

	Q_INVOKABLE QString num() const { return QString("num"); };
	Q_INVOKABLE QString time() const { return QString("time"); };
	Q_INVOKABLE QString additional_time() const { return QString("additional_time"); };
	Q_INVOKABLE QString additional_time_failed() const { return QString("additional_time_failed"); };
	Q_INVOKABLE QString failed() const { return QString("failed"); };
	Q_INVOKABLE QString interval_start() const { return QString("interval_start"); };
	Q_INVOKABLE QString interval_end() const { return QString("interval_end"); };
	Q_INVOKABLE QString interval_failed() const { return QString("interval_failed"); };
	Q_INVOKABLE QString detail_work_times() const { return QString("detail_work_times"); };
	Q_INVOKABLE QString details_work_interval_and_num() const { return QString("details_work_interval_and_num"); };

private:
	explicit InputKeysHolder(QObject* parent = nullptr) : QObject(parent) {};
	InputKeysHolder(const InputKeysHolder&);
	static InputKeysHolder* m_instance;
};