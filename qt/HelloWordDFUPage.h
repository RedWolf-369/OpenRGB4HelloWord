#ifndef HELLOWORDDFUPAGE_H
#define HELLOWORDDFUPAGE_H
#include "ui_HelloWordDFUPage_UI.h"
#include <QFrame>

namespace Ui {
class HelloWordDFUPage;
}

class Ui::HelloWordDFUPage : public QFrame
{
    Q_OBJECT

public:
    explicit HelloWordDFUPage(QWidget *parent = nullptr);
    ~HelloWordDFUPage();
    bool isUpdating = false;
private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

private:
    Ui::HelloWordDFUPageUi *ui;
};

#endif // HELLOWORDDFUPAGE_H
