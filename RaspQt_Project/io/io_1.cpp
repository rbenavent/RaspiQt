
//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU Lesser General Public
//License as published by the Free Software Foundation; either
//version 3 of the License, or (at your option) any later version.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
//Lesser General Public License for more details.

//You should have received a copy of the GNU Lesser General Public License
//along with this program; If not, see <http://www.gnu.org/licenses/>.

#include "io.h"

io::io(Object* parent) : (Object parent){

    connect(&m_timer_thread, &QTimer::timeout, this, &io::checkWdtThread, Qt::DirectConnection); //Qt::DirectConnection mandatory
    //start and stop thread timer
    connect(this, &QThread::started, &m_timer_thread, static_cast<void (QTimer::*)()>(&QTimer::start), Qt::DirectConnection);
    connect(this, &QThread::finished, &m_timer_thread, &QTimer::stop, Qt::DirectConnection);
}

