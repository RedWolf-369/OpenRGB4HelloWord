#include "HelloWordDFUPage.h"
#include "ui_HelloWordDFUPage_UI.h"
#include "QFileDialog"
#include "LogManager.h"
#include <qprocess.h>


#define DFU_UPLOADER "./dfu/dfu-util.exe"
#define DFU_DEVICE_ID "[0843:df11]"
using namespace Ui;

HelloWordDFUPage::HelloWordDFUPage(QWidget *parent) :
    QFrame(parent),
    ui(new Ui::HelloWordDFUPageUi)
{
    ui->setupUi(this);
}

HelloWordDFUPage::~HelloWordDFUPage()
{
    delete ui;
}

void HelloWordDFUPage::on_pushButton_clicked()
{
    ui->plainTextEdit->clear();
    if(isUpdating){
           ui->plainTextEdit->appendPlainText(QString::fromLocal8Bit("请查看是否在升级中！"));
           return;
    }

        QString fileName = QFileDialog::getOpenFileName(this,QString::fromLocal8Bit("打开文件"),"C:/",tr("DFU Files(*.dfu)"));
        if(fileName.isEmpty()){
            ui->plainTextEdit->appendPlainText("no file is selected");
            isUpdating = false;
            return;
        }
        isUpdating = true;
        QProcess *process = new QProcess;
        QString program =QCoreApplication::applicationDirPath() + DFU_UPLOADER;
        QFileInfo fileInfo(program);
        if(!fileInfo.isFile()){
            ui->plainTextEdit->appendPlainText("dfu-utils.exe is not found!");
            return;
        }
       connect(process, &QProcess::readyReadStandardOutput, this, [=]()
       {
           QString msg = QString::fromLocal8Bit(process->readAllStandardOutput());
           ui->plainTextEdit->appendPlainText(msg);
           msg.clear();
       });

       connect(process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished), [ = ](int exitCode, QProcess::ExitStatus exitStatus)
       {
           if(exitStatus == QProcess::NormalExit){
             ui->plainTextEdit->appendPlainText("\n update success! if it`s not run , please try update again\n");
           }else{
             ui->plainTextEdit->appendPlainText("\nupdate error!!!   please check the connection of your keyboard \n");
           }
           LOG_DEBUG("dfu-util.exe process finished.\n");
           isUpdating = false;
       });
       QStringList arguments;
       arguments<<"-D"<< fileName << "-d" << DFU_DEVICE_ID;
       process->start(program,arguments);
}


void HelloWordDFUPage::on_pushButton_2_clicked()
{
    isUpdating = false;
}

