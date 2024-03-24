#include "./include/InputKeysHolder.h"

InputKeysHolder* InputKeysHolder::m_instance = nullptr;

InputKeysHolder* InputKeysHolder::instance() {
	if (!m_instance) {
		m_instance = new InputKeysHolder();
	}

	return m_instance;
}