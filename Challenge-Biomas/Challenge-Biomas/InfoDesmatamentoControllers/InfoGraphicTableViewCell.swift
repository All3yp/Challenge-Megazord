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
    
    func set(entries: [ChartDataEntry], frame: CGRect, estado: Estado){
        self.entries = entries
        lineChart.frame = frame
        title.text = estado.nome
        descriptionText.text = estado.descricao
        configureBarChart()
    }
    
    func configureBarChart(){
        
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelFont = UIFont.systemFont(ofSize: 8, weight: .semibold)
        lineChart.xAxis.labelPosition = .bottom
        //lineChart.leftAxis.setLabelCount(6, force: false)
        //lineChart.xAxis.setLabelCount(10, force: true)
        lineChart.xAxis.labelFont = UIFont.systemFont(ofSize: 8, weight: .semibold)
        lineChart.animate(xAxisDuration: 2.5)
        
        var entries1 = [ChartDataEntry]()
        var entries2 = [ChartDataEntry]()
        for i in 0...entries.count - 1 {
            
            if i < entries.count{
                
                entries1.append(entries[i])
            
            }
            if i >= entries.count - 2 {
                
                entries2.append(entries[i])
                
            }
            
        }
        
        let dataSet1 = LineChartDataSet(entries: entries1, label: "Medidas Anuais")
        let dataSet2 = LineChartDataSet(entries: entries2, label: "Último ano")
        dataSet1.setColors(UIColor(named: "mygreen")!)
        dataSet2.setColors(UIColor(named: "myred")!)
        dataSet1.circleHoleColor = UIColor(named: "mygreen")!
        dataSet2.circleHoleColor = UIColor(named: "myred")!
        dataSet1.setCircleColors(UIColor(named: "mygreen")!)
        dataSet2.setCircleColor(UIColor(named: "myred")!)
        dataSet1.mode = .cubicBezier
        dataSet2.mode = .cubicBezier
        dataSet1.fill = Fill(color: UIColor(named: "mygreen")!)
        dataSet2.fill = Fill(color: UIColor(named: "myred")!)
        dataSet1.fillAlpha = 0.7
        dataSet2.fillAlpha = 0.7
        dataSet1.drawFilledEnabled = true
        dataSet2.drawFilledEnabled = true
        dataSet1.circleRadius = 7
        dataSet2.circleRadius = 7
        
        let data = LineChartData(dataSets: [dataSet1, dataSet2])
        lineChart.data = data
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 8).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineChart.heightAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true

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
