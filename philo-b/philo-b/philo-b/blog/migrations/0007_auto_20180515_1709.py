# Generated by Django 2.0.5 on 2018-05-15 17:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0006_auto_20180515_0314'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='is_first',
            field=models.BooleanField(default=None),
        ),
        migrations.AlterField(
            model_name='comment',
            name='is_last',
            field=models.BooleanField(default=None),
        ),
    ]
