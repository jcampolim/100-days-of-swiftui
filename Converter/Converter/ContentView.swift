import SwiftUI

struct ContentView: View {
    let units: [String] = ["Temperature", "Length", "Time", "Volume"]
    
    let unitsTemperature: [Dimension] = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    let unitsLength: [Dimension] = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    let unitsTime: [Dimension] = [UnitDuration.milliseconds, UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    let unitsVolume: [Dimension] = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]

    @State private var selectedUnit: String = "Temperature"

    @State private var inputValue: Double = 0
    @State private var unitFrom: Dimension = UnitTemperature.celsius
    @State private var unitTo: Dimension = UnitTemperature.celsius
    
    var currentUnitList: [Dimension] {
        switch selectedUnit {
        case "Temperature": return unitsTemperature
        case "Length": return unitsLength
        case "Time": return unitsTime
        case "Volume": return unitsVolume
        default: return unitsTemperature
        }
    }

    var convertedValue: Double {
        let input = Measurement(value: inputValue, unit: unitFrom)
        let output = input.converted(to: unitTo)
        return output.value
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                VStack(alignment: .leading, spacing: 8) {
                    Picker("", selection: $selectedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)

                    TextField("", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 36, weight: .bold))
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                VStack(spacing: 16) {
                    Picker("From", selection: $unitFrom) {
                        ForEach(currentUnitList, id: \.self) { unit in
                            Text(unit.symbol).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("To", selection: $unitTo) {
                        ForEach(currentUnitList, id: \.self) { unit in
                            Text(unit.symbol).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(selectedUnit + " converted").font(.headline)

                    Text(
                        convertedValue,
                        format: .number.precision(.fractionLength(2))
                    )
                    .font(.system(size: 36, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding()
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}   
