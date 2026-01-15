#!/usr/bin/env python3
"""
Adjust colors in Helix theme files to compensate for Ghostty rendering differences.

This script adds 5 to the red channel of all hex colors to counteract Ghostty's
tendency to render colors with reduced red values compared to other terminals/editors.

Usage:
    python3 adjust_colors.py [filename]
    
If no filename is provided, it will process terafox.toml by default.
"""

import re
import sys
import os

def adjust_color(hex_color, adjustment=5):
    """
    Adjust a hex color by modifying the red channel.
    
    Args:
        hex_color: Hex color string (e.g., '#152528')
        adjustment: Amount to add to the red channel (default: 5)
    
    Returns:
        Adjusted hex color string in uppercase
    """
    # Remove the # if present
    color = hex_color.lstrip('#')
    
    # Convert to RGB
    r = int(color[0:2], 16)
    g = int(color[2:4], 16)
    b = int(color[4:6], 16)
    
    # Add adjustment to red channel (capped at 255)
    r = min(255, r + adjustment)
    
    # Convert back to hex
    return f"#{r:02x}{g:02x}{b:02x}".upper()

def process_file(filepath, adjustment=5):
    """
    Process a theme file and adjust all hex colors.
    
    Args:
        filepath: Path to the theme file
        adjustment: Amount to add to the red channel (default: 5)
    """
    # Check if file exists
    if not os.path.exists(filepath):
        print(f"Error: File '{filepath}' not found!")
        return False
    
    # Read the file
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Find all hex colors (6-digit format)
    hex_pattern = r'#[0-9a-fA-F]{6}'
    colors_found = set(re.findall(hex_pattern, content))
    
    if not colors_found:
        print("No hex colors found in the file.")
        return False
    
    print(f"Processing: {filepath}")
    print(f"Adjustment: Adding {adjustment} to red channel")
    print("\nColors to adjust:")
    
    # Show the adjustments that will be made
    for color in sorted(colors_found):
        new_color = adjust_color(color, adjustment)
        print(f"  {color} -> {new_color}")
    
    # Ask for confirmation
    response = input("\nProceed with color adjustment? (y/n): ").lower()
    if response != 'y':
        print("Operation cancelled.")
        return False
    
    # Replace all colors
    for color in colors_found:
        new_color = adjust_color(color, adjustment)
        content = content.replace(color, new_color)
    
    # Create backup
    backup_path = filepath + '.backup'
    with open(backup_path, 'w') as f:
        with open(filepath, 'r') as original:
            f.write(original.read())
    print(f"\nBackup created: {backup_path}")
    
    # Write the adjusted file
    with open(filepath, 'w') as f:
        f.write(content)
    
    print(f"File updated successfully: {filepath}")
    return True

def main():
    # Default file
    default_file = '/Users/austinwasson/.config/helix/themes/terafox.toml'
    
    # Get filename from command line or use default
    if len(sys.argv) > 1:
        filepath = sys.argv[1]
    else:
        filepath = default_file
    
    # Optional: Get adjustment value from command line
    adjustment = 5
    if len(sys.argv) > 2:
        try:
            adjustment = int(sys.argv[2])
        except ValueError:
            print(f"Invalid adjustment value: {sys.argv[2]}")
            print("Using default adjustment of 5")
    
    # Process the file
    process_file(filepath, adjustment)

if __name__ == "__main__":
    main()