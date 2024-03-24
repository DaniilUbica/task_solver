#pragma once

#include <QObject>

class TaskSolver : public QObject {
    Q_OBJECT

public:
    TaskSolver(QObject *parent = nullptr);

    Q_PROPERTY(QString resultValues MEMBER m_resultValues NOTIFY resultValuesChanged)
    Q_SIGNAL void resultValuesChanged();

    Q_INVOKABLE void setInputData(const QString& data);
    Q_INVOKABLE void solveTask(uint task_number);

private:
    float successProbability(float num, float failed_num);
    float failureProbability(float num, float failed_num);
    float failureRate(float num, float t1, float t2, float interval_failure_num);
    float failureIntensivity(float num, float t1, float t2, float interval_failure_num, float failed_num);
    float mtbf(float num, std::vector<float>& mtbf_details);

    std::map<QString, float> m_data;
    QString m_resultValues;
};
