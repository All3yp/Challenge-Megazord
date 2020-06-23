//
//  InfoGraphicTableViewCell.swift
//  Challenge-Biomas
//
//  Created by Felipe Santana on 17/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Charts
import UIKit

class InfoGraphicTableViewCell: UITableViewCell {
    
    var title = UILabel()
    var descriptionText = UILabel()
    static let identifier = "InfoGraphicTableViewCell"
    
    var lineChart = LineChartView()
    var entries = [ChartDataEntry]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(descriptionText)
        addSubview(lineChart)
        configureAtributes()
        setTitleConstraints()
        setDescriptionTextConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(entries: [ChartDataEntry], frame: CGRect, section: Section){
        self.entries = entries
        lineChart.frame = frame
        title.text = section.title
        descriptionText.text = section.description
        configureBarChart()
    }
    
    func configureBarChart(){
        
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelFont = UIFont.systemFont(ofSize: 8, weight: .semibold)
        lineChart.xAxis.labelPosition = .bottom
        //lineChart.leftAxis.setLabelCount(6, force: false)
        lineChart.xAxis.setLabelCount(10, force: true)
        lineChart.xAxis.labelFont = UIFont.systemFont(ofSize: 8, weight: .semibold)
        lineChart.animate(xAxisDuration: 2.5)
        
        let dataSet = LineChartDataSet(entries: entries, label: "Medidas Anuais")
        let mygreen = UIColor(displayP3Red: 180/255, green: 191/255, blue: 94/255, alpha: 1)
        dataSet.setColors(UIColor.red)
        dataSet.circleHoleColor = mygreen
        dataSet.setCircleColors(mygreen)
        dataSet.mode = .cubicBezier
        dataSet.fill = Fill(color: mygreen)
        dataSet.fillAlpha = 0.7
        dataSet.drawFilledEnabled = true
        dataSet.circleRadius = 7
        
        let data = LineChartData(dataSet: dataSet)
        //data.setDrawValues(false)
        lineChart.data = data
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 8).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineChart.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true

    }
    
    func configureAtributes() {
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        descriptionText.numberOfLines = 0
        descriptionText.adjustsFontSizeToFitWidth = true
        descriptionText.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    func setTitleConstraints() {
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
    }
    
    func setDescriptionTextConstraints() {
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        
    }

}



//pantanal, cerrado e mata atlantica

